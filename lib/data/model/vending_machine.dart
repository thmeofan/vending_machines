class VendingMachine {
  final String name;
  final String location;
  final List<MachineType> machineTypes;
  final List<Product> products;

  VendingMachine({
    this.name = '',
    this.location = '',
    this.machineTypes = const [],
    this.products = const [],
  });

  VendingMachine copyWith({
    String? name,
    String? location,
    List<MachineType>? machineTypes,
    List<Product>? products,
  }) {
    return VendingMachine(
      name: name ?? this.name,
      location: location ?? this.location,
      machineTypes: machineTypes ?? this.machineTypes,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'machineTypes': machineTypes.map((type) => type.name).toList(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  factory VendingMachine.fromJson(Map<String, dynamic> json) {
    return VendingMachine(
      name: json['name'],
      location: json['location'],
      machineTypes: (json['machineTypes'] as List<String>)
          .map((typeName) => MachineType.values.byName(typeName))
          .toList(),
      products: (json['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }
}

enum MachineType { drinks, food, media, merchandise, medicine }

class Product {
  final String name;
  final double price;
  final String consumption;
  final ConsumptionPeriod consumptionPeriod;

  Product({
    required this.name,
    required this.price,
    required this.consumption,
    required this.consumptionPeriod,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'consumption': consumption,
      'consumptionPeriod': consumptionPeriod.name,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      consumption: json['consumption'],
      consumptionPeriod:
          ConsumptionPeriod.values.byName(json['consumptionPeriod']),
    );
  }
}

enum ConsumptionPeriod { daily, weekly, monthly, annually }
