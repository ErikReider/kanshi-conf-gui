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
    [GtkTemplate (ui = "/org/erikr/kanshi-conf-gui/row/row.ui")]
    public class RowBox : Gtk.Box {
        [GtkChild]
        unowned Gtk.Label label;

        public Profile profile;
        public string label_text;

        public RowBox(Profile profile, string label_text) {
            Object();
            this.label_text = label_text;
            this.profile = profile;
            label.set_text(label_text);
            show_all();
        }
    }
}
