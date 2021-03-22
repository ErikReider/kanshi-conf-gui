/* main.vala
 *
 * Copyright 2021 Erik Reider
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

int main (string[] args) {
    Gtk.init(ref args);
    Hdy.init();

    var app = new Gtk.Application ("org.erikr.kanshi-conf-gui", ApplicationFlags.FLAGS_NONE);
    app.activate.connect (() => {
        var win = app.active_window;
        if (win == null) {
            win = new KanshiConfGui.Window (app, new Parser(config_file()).profiles);
        }
        win.show_all();
    });

    return app.run (args);
}

File config_file() {
    string basePath = GLib.Environment.get_user_config_dir() + "/kanshi";
    // Checks if directory exists. Creates one if none
    if (!GLib.FileUtils.test(basePath, GLib.FileTest.IS_DIR)) {
        try {
            var file = File.new_for_path(basePath);
            file.make_directory();
        } catch (Error e) {
            print("Error: %s\n", e.message);
        }
    }
    // Checks if file exists. Creates one if none
    var file = File.new_for_path (basePath + "/config");
    if (!file.query_exists ()) {
        try {
            file.create(FileCreateFlags.NONE);
        } catch (Error e) {
            print("Error: %s\n", e.message);
            Process.exit(1);
        }
    }

    return file;
}

