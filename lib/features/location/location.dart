// Public API of the location feature. Other features and app/ import only this file.
export 'package:ui_ux/features/location/domain/models/address_input.dart'
        // $AddressInputCopyWith: needed by freezed code of models embedding it.
        show
        AddressInput,
        $AddressInputCopyWith;
export 'package:ui_ux/features/location/presentation/controllers/provinces_provider.dart'
    show provincesProvider;
export 'package:ui_ux/features/location/presentation/widgets/address_fields.dart'
    show AddressFields;
