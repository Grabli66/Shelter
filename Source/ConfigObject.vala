namespace Shelter {
    /*
    *   Find nodes get their values
    */
    public class ConfigObject : Object {
        /*
        *   Root json object
        */
        private Json.Object _root;

        private Gee.HashMap<string, BoxValue> _cache = new Gee.HashMap<string, BoxValue> ();

        /*
        *   Box array from node
        */
        private BoxValue[] BoxArray (Json.Node node) {
            var arr = node.get_array ();
            BoxValue[] res = {};
            arr.foreach_element ((arr, ind, nod) => {
                var tp = nod.get_value_type ();                                
                if (tp.is_a (typeof (string))) {
                    res += new StringBox (nod.get_string ());
                }  else if (tp.is_a (typeof (int64))) {
                    res += new IntegerBox (nod.get_int ());
                } else if (tp.is_a (typeof (double))) {
                    res += new DoubleBox (nod.get_double ());
                } else if (tp.is_a (typeof (Json.Object))) {
                    var confObj = new ConfigObject (nod.get_object ());
                    res += new ObjectBox (confObj);
                }
            });   
            return res;
        }

        /*
        *   Return node for path
        */
        private Json.Node GetNode (string path) throws ShelterErrors.Common {
            try {                
                var items = path.split (".");
                Json.Object node = _root;
                for (int i = 0; i < items.length; i++) {
                    var item = items[i];                    
                    if (!node.has_member (item)) throw new ShelterErrors.Common ("Node not found");
                    if (i < items.length - 1) {                                                                        
                        node = node.get_object_member (item);
                        if (node == null) throw new ShelterErrors.Common ("Wrong path");
                    } else {
                        var nod = node.get_member (item);
                        if (nod == null) throw new ShelterErrors.Common ("Wrong path");
                        return nod;
                    }
                }
                throw new ShelterErrors.Common ("Node not found");
            } catch {
                throw new ShelterErrors.Common ("Cant get node");
            }            
        }

        internal ConfigObject (Json.Object root) {
            _root = root;            
        }

        /*
        *   Get string item
        */
        public string GetString (string path) throws ShelterErrors.Common {
            var box = _cache[path] as StringBox;
            if (box != null) {                
                return box.Data;
            }

            var node = GetNode (path);            
            box = new StringBox (node.get_string ());            
            _cache[path] = box;
            return box.Data;
        }

        /*
        *   Get integer item
        */
        public int64 GetInteger (string path) {
            var box = _cache[path] as IntegerBox;
            if (box != null) {                
                return box.Data;
            }

            var node = GetNode (path);            
            box = new IntegerBox (node.get_int ());            
            _cache[path] = box;
            return box.Data;
        }

        /*
        *   Get double item
        */
        public double GetDouble (string path) {
            var box = _cache[path] as DoubleBox;
            if (box != null) {                
                return box.Data;
            }

           var node = GetNode (path);            
            box = new DoubleBox (node.get_double ());            
            _cache[path] = box;
            return box.Data;
        }

        /*
        *   Get array item
        */
        public BoxValue[] GetArray (string path) {
            var box = _cache[path] as ArrayBox;
            if (box != null) {                
                return box.Data;
            }

            var node = GetNode (path);                        
            return BoxArray (node);
        }

        /*
        *   Get object item
        */
        public ConfigObject GetObject (string path) {
            var box = _cache[path] as ObjectBox;
            if (box != null) {                
                return box.Data;
            }
            
            var node = GetNode (path);
            var confObj = new ConfigObject (node.get_object ());            
            box = new ObjectBox (confObj);            
            _cache[path] = box;
            return box.Data;
        }
    }
}