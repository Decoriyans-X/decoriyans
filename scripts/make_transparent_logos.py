from PIL import Image
from pathlib import Path

src_title = Path(
    r"C:\Users\AllwinsR\.cursor\projects\c-Users-AllwinsR-MySpace-MyWorkspace-decoriyans\assets\c__Users_AllwinsR_AppData_Roaming_Cursor_User_workspaceStorage_empty-window_images_decoriyans-ff348c09-554b-4fee-b5ea-91c723dc769a.png"
)
src_mark = Path(
    r"C:\Users\AllwinsR\.cursor\projects\c-Users-AllwinsR-MySpace-MyWorkspace-decoriyans\assets\c__Users_AllwinsR_AppData_Roaming_Cursor_User_workspaceStorage_empty-window_images_D-ddb10b26-621f-4902-bae5-62721e5b3353.png"
)

out_dir = Path(r"C:\Users\AllwinsR\_MySpace\_MyWorkspace\decoriyans\app\assets\brand")
out_dir.mkdir(parents=True, exist_ok=True)


def white_to_alpha(img: Image.Image, threshold: int = 245, soft: int = 18) -> Image.Image:
    """Make near-white pixels transparent; preserve colored/gradient pixels."""
    rgba = img.convert("RGBA")
    pixels = rgba.load()
    w, h = rgba.size
    for y in range(h):
        for x in range(w):
            r, g, b, a = pixels[x, y]
            mn = min(r, g, b)
            mx = max(r, g, b)
            chroma = mx - mn
            if mn >= threshold and chroma <= soft:
                pixels[x, y] = (r, g, b, 0)
            elif mn >= threshold - 28 and chroma <= soft + 12:
                fade = int(255 * (threshold - mn) / 28)
                fade = max(0, min(255, fade))
                pixels[x, y] = (r, g, b, fade)
    return rgba


def crop_transparent(img: Image.Image, pad: int = 8) -> Image.Image:
    bbox = img.getbbox()
    if not bbox:
        return img
    l, t, r, b = bbox
    l = max(0, l - pad)
    t = max(0, t - pad)
    r = min(img.width, r + pad)
    b = min(img.height, b + pad)
    return img.crop((l, t, r, b))


title = white_to_alpha(Image.open(src_title), threshold=248, soft=20)
title = crop_transparent(title)
title_path = out_dir / "logo_title.png"
title.save(title_path, "PNG")

mark = white_to_alpha(Image.open(src_mark), threshold=248, soft=22)
mark = crop_transparent(mark)
mark_path = out_dir / "logo_mark.png"
mark.save(mark_path, "PNG")

gap = 24
scale = (title.height * 0.9) / mark.height
mark_r = mark.resize(
    (max(1, int(mark.width * scale)), max(1, int(mark.height * scale))),
    Image.Resampling.LANCZOS,
)
combined = Image.new(
    "RGBA",
    (mark_r.width + gap + title.width, max(mark_r.height, title.height)),
    (0, 0, 0, 0),
)
mark_y = (combined.height - mark_r.height) // 2
title_y = (combined.height - title.height) // 2
combined.paste(mark_r, (0, mark_y), mark_r)
combined.paste(title, (mark_r.width + gap, title_y), title)
combined_path = out_dir / "logo.png"
combined.save(combined_path, "PNG")

root = Path(r"C:\Users\AllwinsR\_MySpace\_MyWorkspace\decoriyans\assets\brand")
root.mkdir(parents=True, exist_ok=True)
for p in (title_path, mark_path, combined_path):
    (root / p.name).write_bytes(p.read_bytes())

print("title", title.size, title_path)
print("mark", mark.size, mark_path)
print("combined", combined.size, combined_path)
