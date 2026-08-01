from PIL import Image
from pathlib import Path

src = Path(
    r"C:\Users\AllwinsR\.cursor\projects\c-Users-AllwinsR-MySpace-MyWorkspace-decoriyans\assets\c__Users_AllwinsR_AppData_Roaming_Cursor_User_workspaceStorage_empty-window_images_ChatGPT_Image_Aug_1__2026__05_52_04_PM-4a815ff1-4f8f-49d0-938d-32846f292fc5.png"
)

out_dir = Path(r"C:\Users\AllwinsR\_MySpace\_MyWorkspace\decoriyans\app\assets\brand")
out_dir.mkdir(parents=True, exist_ok=True)
root = Path(r"C:\Users\AllwinsR\_MySpace\_MyWorkspace\decoriyans\assets\brand")
root.mkdir(parents=True, exist_ok=True)


def black_to_alpha(img: Image.Image, threshold: int = 28, soft: int = 18) -> Image.Image:
    """Make near-black background transparent; keep teal/gold logo pixels."""
    rgba = img.convert("RGBA")
    pixels = rgba.load()
    w, h = rgba.size
    for y in range(h):
        for x in range(w):
            r, g, b, a = pixels[x, y]
            mx = max(r, g, b)
            mn = min(r, g, b)
            chroma = mx - mn
            # Near-black, low chroma => background
            if mx <= threshold and chroma <= soft:
                pixels[x, y] = (r, g, b, 0)
            elif mx <= threshold + soft and chroma <= soft + 8:
                # Soft fringe for anti-aliased edges
                fade = int(255 * (mx - threshold) / soft) if soft else 0
                fade = max(0, min(255, fade))
                pixels[x, y] = (r, g, b, fade)
    return rgba


def crop_transparent(img: Image.Image, pad: int = 12) -> Image.Image:
    bbox = img.getbbox()
    if not bbox:
        return img
    l, t, r, b = bbox
    l = max(0, l - pad)
    t = max(0, t - pad)
    r = min(img.width, r + pad)
    b = min(img.height, b + pad)
    return img.crop((l, t, r, b))


logo = black_to_alpha(Image.open(src), threshold=32, soft=20)
logo = crop_transparent(logo)

logo_path = out_dir / "logo.png"
logo.save(logo_path, "PNG")
(root / "logo.png").write_bytes(logo_path.read_bytes())

# Also keep as dedicated lockup asset
lockup = out_dir / "logo_lockup.png"
logo.save(lockup, "PNG")
(root / "logo_lockup.png").write_bytes(lockup.read_bytes())

# Favicon from left portion (icon area)
icon_w = min(logo.height, logo.width // 3)
icon = logo.crop((0, 0, icon_w, logo.height))
icon = crop_transparent(icon, pad=4)
# square canvas
side = max(icon.width, icon.height)
sq = Image.new("RGBA", (side, side), (0, 0, 0, 0))
sq.paste(icon, ((side - icon.width) // 2, (side - icon.height) // 2), icon)
mark_path = out_dir / "logo_mark.png"
sq.save(mark_path, "PNG")
(root / "logo_mark.png").write_bytes(mark_path.read_bytes())

# Web favicon
favicon = Path(r"C:\Users\AllwinsR\_MySpace\_MyWorkspace\decoriyans\app\web\favicon.png")
sq.resize((192, 192), Image.Resampling.LANCZOS).save(favicon, "PNG")

print("logo", logo.size, logo_path)
print("mark", sq.size, mark_path)

# Verify corners transparent
px = logo.load()
print(
    "corners",
    px[0, 0],
    px[logo.width - 1, 0],
    px[0, logo.height - 1],
    px[logo.width - 1, logo.height - 1],
)
