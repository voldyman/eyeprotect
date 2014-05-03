/**
 * keyboard_grab deprecated,
 * show a window on all screens
 * animation like clutter's ease quad
 */

int main (string[] args) {
	Gtk.init (ref args);

	var wind  = new WaitWindow ();
	wind.destroy.connect (Gtk.main_quit);

	wind.show_all ();
	
	Gtk.main ();
	return 0;
}
