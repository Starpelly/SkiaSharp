using System;
using SkiaSharp;
using System.IO;
using internal SkiaSharp;

namespace Sandbox;

class Program
{
	public static int Main(String[] args)
	{
		let srgb = SkiaApi.sk_colorspace_new_srgb();

		// let bitmap = scope SKBitmap(800, 600);
		var image_info = SKImageInfoNative()
			{
				width = 256,
				height = 256,
				colorType = .Rgba8888,
				alphaType = .Opaque,
				colorspace = null
			};
		let surface = SkiaApi.sk_surface_new_raster(&image_info, 0, null);

		let canvas = SkiaApi.sk_surface_get_canvas(surface);

		SkiaApi.sk_canvas_clear(canvas, 0xFFFFFF);

		let image = SkiaApi.sk_surface_new_image_snapshot(surface);

		let pngData = SkiaApi.sk_image_ref_encoded(image);
		let span = Span<uint8>((uint8*)SkiaApi.sk_data_get_data(pngData),  SkiaApi.sk_data_get_size(pngData));

		File.WriteAll("test.png", span);

		return 0;
	}
}