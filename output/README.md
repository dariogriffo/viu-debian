## viu - Command-line image viewer

viu is a small command-line application to view images from the terminal written in Rust.

It supports various image display protocols:
- 🖼️ **Kitty** terminal graphics protocol
- 🖼️ **iTerm2** inline images protocol
- 🖼️ **Sixel** graphics format
- 🔠 **Unicode block characters** as fallback for all other terminals

### Usage

```sh
viu image.png
viu image.jpg
viu *.gif
```

### Supported formats

PNG, JPEG, GIF, BMP, ICO, TIFF, WebP, AVIF, and more via the `image` crate.

## License

viu is MIT-licensed. For more information check the [LICENSE](https://github.com/atanunq/viu/blob/master/LICENSE) file.
