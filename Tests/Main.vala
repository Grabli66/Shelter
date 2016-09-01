using Shelter;

internal void InfoLn (string s) {
    stderr.printf (s + "\n");
}

internal const string HOST = "local";
internal const int PORT = 3369;
internal const double TIMESTAMP = 123456789.123456789;

public void main () {
    Configuration.Load ("Settings.json");
    try {            
        // Get data from settings
        var stringRes = Configuration.GetString ("Connection.Host");
        // Test cache
        stringRes = Configuration.GetString ("Connection.Host");        
        if (stringRes != HOST) throw new ShelterErrors.Common ("");
        InfoLn ("Get string - good");
    } catch {
        InfoLn ("Get string - error");
        return;
    }    

    try {                
        // Get data from settings
        var intRes = Configuration.GetInteger ("Connection.Port");
        // Test cache
        intRes = Configuration.GetInteger ("Connection.Port");        
        if (intRes != PORT) throw new ShelterErrors.Common ("");                        
        InfoLn ("Get int - good");        
    } catch {
        InfoLn ("Get int - error");
        return;
    }  

    try {                
        // Get data from settings
        var doubleRes = Configuration.GetDouble ("Timestamp");
        // Test cache
        doubleRes = Configuration.GetDouble ("Timestamp");        
        if (doubleRes != TIMESTAMP) throw new ShelterErrors.Common ("");                               
        InfoLn ("Get double - good");        
    } catch {
        InfoLn ("Get double - error");
        return;
    }

    try {                
        // Get data from settings
        var objectRes = Configuration.GetObject ("Credentials");
        // Test cache
        objectRes = Configuration.GetObject ("Credentials");
        var str = objectRes.GetString ("Login");        
        if (str != "user") throw new ShelterErrors.Common ("");
        InfoLn ("Get object - good");        
    } catch {        
        InfoLn ("Get object - error");
        return;
    }        

    try {                
        // Get data from settings
        var arrRes = Configuration.GetArray ("Array");
        // Test cache
        arrRes = Configuration.GetArray ("Array");
        var intDat = arrRes[0] as IntegerBox;
        var strDat = arrRes[1] as StringBox;
        var doubleDat = arrRes[2] as DoubleBox;
        var objDat = arrRes[3] as ObjectBox;
        var nameDat = objDat.Data.GetString ("Name");
        if (intDat.Data != 1) throw new ShelterErrors.Common ("");
        if (strDat.Data != "GOOD") throw new ShelterErrors.Common ("");
        if (doubleDat.Data != 3.2) throw new ShelterErrors.Common ("");
        if (nameDat != "John") throw new ShelterErrors.Common ("");

        InfoLn ("Get array - good");        
    } catch {        
        InfoLn ("Get array - error");
        return;
    }              
}
    