

import 'package:fashion_store_app/features/shipping_address_screen/models/address.dart';

class AddressRepository {
  List<Address> getAddresses(){
    return const[
      Address(
        id: '1', 
        label: 'Home', 
        fullAddress: 'No.28, olcet Rd, Matara', 
        city: 'Matara', 
        state: 'Matara', 
        zipCode: '810000',
        isDefault: true,
        type: AddressType.home
      ),
      Address(
        id: '1', 
        label: 'office', 
        fullAddress: 'No.28, Business Ave, galle Rd, Matara', 
        city: 'Matara', 
        state: 'Matara', 
        zipCode: '810000',
        isDefault: true,
        type: AddressType.office,
      ),
  
    ];
  }
  Address? getDefaultAddress(){
    return getAddresses().firstWhere(
      (address) => address.isDefault,
      orElse: () => getAddresses().first,
    );
  }
}