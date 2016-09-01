namespace Shelter {
    /*
    *   Value for boxing
    */
    public class BoxValue : Object {          
    }

    /*
    *   Box for string
    */
    public class StringBox : BoxValue {
        public string Data {get; private set; }

        public StringBox (string data) {
            Data = data;
        }
    }

    /*
    *   Box for integer
    */
    public class IntegerBox : BoxValue {
        public int64 Data {get; private set; }

        public IntegerBox (int64 data) {
            Data = data;
        }
    }  

    /*
    *   Box for double
    */
    public class DoubleBox : BoxValue {
        public double Data {get; private set; }

        public DoubleBox (double data) {
            Data = data;
        }
    }  

    /*
    *   Box for array
    */
    public class ArrayBox : BoxValue {
        public BoxValue[] Data {get; private set; }

        public ArrayBox (BoxValue[] data) {
            Data = data;
        }
    }

    /*
    *   Box for object
    */
    public class ObjectBox : BoxValue {
        public ConfigObject Data {get; private set; }

        public ObjectBox (ConfigObject data) {
            Data = data;
        }
    }
}