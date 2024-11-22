#include "screen.h"

void print_char(char character, int col, int row, char attribute_byte) {
  unsigned char *vidmem = (unsigned char *)VIDEO_ADDRESS;
  int offset;
  int rows;

  if (!attribute_byte)
    attribute_byte = WHITE_ON_BLACK;

  if (col >= 0 && row >= 0)
    offset = get_screen_offset(col, row);
  else
    offset = get_cursor();

  if (character == '\n') {
    rows = offset / (2 * MAX_COLS);
    offset = get_screen_offset(79, rows);
  } else {
    vidmem[offset] = character;
    vidmem[offset + 1] = attribute_byte;
  }

  offset += 2;
  offset = handle_scrolling(offset);
  set_cursor(offset);
}

int get_cursor() {

}
int get_screen_offset(int col, int row) {
	return (0);
}
