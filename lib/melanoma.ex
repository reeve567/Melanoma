defmodule Melanoma do
  @kernel_size 5
  @kernel_shape "Diamond"

  @kernel_sizes [3,5,7]
  @kernel_shapes ["Diamond", "Rectangle", "Disk", "Octagon", "Cross"]

  @temp_images_path "temp_images"
  @saved_images_path "saved_images"
  @source_path "./images/*/*.jpg"

  def makeSubFolder(base, name) do
    if !File.exists?(base) do
      File.mkdir(base)
    end

    if !File.exists?(base <> "/#{name}") do
      File.mkdir!(base <> "/#{name}")
    end
  end

  def setup() do
    makeSubFolder(@temp_images_path, "melanoma")
    makeSubFolder(@temp_images_path, "not")

    makeSubFolder(@saved_images_path, "melanoma")
    makeSubFolder(@saved_images_path, "not")
  end

  def handleImage(path) do
    saved_image_path = String.replace(path, "images", @saved_images_path)
    temp_image_path = String.replace(path, "images", @temp_images_path)

    IO.puts("Processing #{path}")

    bottom_hat(path, saved_image_path, temp_image_path, @kernel_shape, @kernel_size)
  end

  def bottom_hat(path, save_path, temp_path, shape, size) do
    main_command = "convert #{path} -morphology BottomHat #{shape}:#{size} #{temp_path}"
    System.cmd("cmd.exe", ["/c", main_command])

    subtract_command = "convert #{temp_path} #{path} -compose minus -composite #{save_path}"
    System.cmd("cmd.exe", ["/c", subtract_command])
  end

  def top_hat(path, save_path, temp_path, shape, size) do
    main_command = "convert #{path} -morphology TopHat #{shape}:#{size} #{temp_path}"
    System.cmd("cmd.exe", ["/c", main_command])

    subtract_command = "convert #{temp_path} #{path} -compose minus -composite #{save_path}"
    System.cmd("cmd.exe", ["/c", subtract_command])
  end

  def analyzeImage(path) do
    saved_image_path = String.replace(path, "images", @saved_images_path)
    temp_image_path = String.replace(path, "images", @temp_images_path)

    IO.puts("Processing #{path}...")
    IO.puts("Saving to #{saved_image_path}...")

    Enum.map(@kernel_shapes, fn shape ->
      Enum.map(@kernel_sizes, fn size ->
        temp_path = String.replace(temp_image_path, ".jpg", "_#{shape}_#{size}.jpg")
        save_path = String.replace(saved_image_path, ".jpg", "_#{shape}_#{size}.jpg")

        top_hat(path, save_path, temp_path, shape, size)
      end)
    end)
  end

  def handleImages() do
    setup()
    source_images = Path.wildcard(@source_path)
    IO.puts("Listing source images from #{@source_path}...")

    Enum.map(source_images, fn val ->
      handleImage(val)
    end)
  end
end

Melanoma.handleImages()