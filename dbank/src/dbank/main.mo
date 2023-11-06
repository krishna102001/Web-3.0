import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";
// actor is canisters
actor DBank{ //DBank is container 
  stable var currentValue: Float = 300; //create a variable 
  // currentValue := 100; //we can reassign the value 
  stable var startTime = Time.now();
  // startTime := Time.now();
  Debug.print(debug_show(startTime));

  //this is private function which is accesible for only this canisters to make public use "public" keyword
  public func topUp(amount: Float){ //amount is variable and its data type is Nat means natural number
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };
  public func withDrawl(amount : Float){
    let tempValue: Float = currentValue - amount;
    if(tempValue >=0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    }else{
      Debug.print("Insufficient Balance")
    }
  };
  public query func checkBalance(): async Float{
    return currentValue;
  };
  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  }
}
// dfx canister id __Candid_U
// http://127.0.0.1:8000/?canisterId=r7inp-6aaaa-aaaaa-aaabq-cai
// dfx canister id dbank