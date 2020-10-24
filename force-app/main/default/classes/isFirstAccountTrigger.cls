public class isFirstAccountTrigger {
    
    private static Boolean isFirst = true;
    
    public static Boolean isFirstFunc() {
        if(isFirst) {
            isFirst = false;
            return true;
        } else {
            return false;
        }
    }
    
}