# UI design specification

## Source-of-truth artwork

The live artwork is in `assets/images/`: `title.png`, `menu.png`, `field.png`, and transparent player/guard pose PNGs. Menus reuse the clean backgrounds. All labels and controls are Flutter widgets.

## Style tokens
- Screen: portrait 9:16; safe areas always respected.
- Primary yellow `#FFB51D`, blue `#65C9FA`, light beige `#FFF2CF`, brown outline `#76401C`, grass green `#B8DC99`.
- Buttons: rounded, thick dark border, elevation/shadow, >=48 px touch target.
- Type: heavy rounded sans with Vietnamese diacritics; bundled font is not included.
- Game contrast: player white/red, guards GREEN, lane WHITE, finish RED.

## MVP flow
Home -> Select -> Game -> Win/Lose; Home -> Tutorial -> Game; Home -> Settings; Game -> Pause -> Resume/Restart/Home.

## Rendering
The background PNGs contain no controls or labels. Flutter provides the live, accessible text and buttons; Flame places sprites on the field.
