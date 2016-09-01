
namespace Shelter {
    /*
    *   Class for manage configuration
    */
    [Compact]
    public class Configuration {
        /*
        *   Root object of settings
        */
        private static ConfigObject _root;                

        /*
        *   Load configuration from file
        */
        public static void Load (string path) {
            var parser = new Json.Parser ();
            parser.load_from_file (path);
            var root = parser.get_root ().get_object ();
            _root = new ConfigObject (root);
        }

        /*
        *   Get string item
        */
        public static string GetString (string path) throws ShelterErrors.Common {            
            return _root.GetString (path);            
        }

        /*
        *   Get integer item
        */
        public static int64 GetInteger (string path) {            
            return _root.GetInteger (path);
        }

        /*
        *   Get double item
        */
        public static double GetDouble (string path) {           
            return _root.GetDouble (path);
        }

        /*
        *   Get array item
        */
        public static BoxValue[] GetArray (string path) {
            return _root.GetArray (path);
        }

        /*
        *   Get object item
        */
        public static ConfigObject GetObject (string path) {
            return _root.GetObject (path);
        }
    }
}