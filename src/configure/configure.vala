/* window.vala
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

namespace KanshiConfGui {
    [GtkTemplate (ui = "/org/erikr/kanshi-conf-gui/configure/configure.ui")]
    public class Configure : Gtk.Box {
        [GtkChild]
        unowned Gtk.Label title;

        public Profile profile;
        public string index;
        public string text;

        public Configure (Profile profile, string index, string text) {
            Object();
            this.profile = profile;
            this.index = index;
            this.text = text;
            title.set_label(text);
        }
    }
}
