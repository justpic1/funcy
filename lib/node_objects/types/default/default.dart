import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/node_objects/types/function.dart';
import 'dart:math' as math;

import 'package:signals/signals.dart';
class DefaultNodes {
  static Map<String, Function> functions = {
    "sum": sum,
    "add": add,
    "product": product,
    "multiply": multiply,
    "subtract": subtract,
    "divide": divide,
    "average": average,
    "average rows": averageByRow,
    "concatenate string": concatenateString,
    "concatenate list": concatenateList,
    "concatenate int": concatenateInt,
    "sin": sin,
    "cos": cos,
    "tan": tan,
    "asin": asin,
    "acos": acos,
    "atan": atan,
    "power": power,
    "sqrt": sqrt,
    "log": log,
    "log10": log10,
    "exp": exp,
    "abs": abs,
    "ceil": ceil,
    "floor": floor,
    "round": round,
    "max": max,
    "min": min,
    "random": random,
    "if": ifNode,
    "and": andNode,
    "or": orNode,
    "not": notNode,
    "xor": xorNode,
    "nand": nandNode,
    "nor": norNode,
    "xnor": xnorNode,
    "equal": equalNode,
    "not equal": notEqualNode,
    "greater than": greaterThanNode,
    "less than": lessThanNode,
    "greater than or equal": greaterThanOrEqualNode,
    "less than or equal": lessThanOrEqualNode,
    "percent": percent,


  };
  static FunctionNode sum(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'SUM',
      types: const [List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        return
      // 1 dimensional addition 
      inputs.expand((i) => i).reduce((a, b) => a + b);
      }, 
    );
  }
  static FunctionNode add(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'ADD',
      types: const [List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length == 1) {
          return inputs[0];
        }
        // 2 dimensional addition
    return [inputs.reduce((a, b) {
      final length = a.length > b.length ? a.length : b.length;
      return List.generate(length, (index) {
        final aValue = index < a.length ? a[index] : 0;
        final bValue = index < b.length ? b[index] : 0;
        return aValue + bValue;
      });
    })];
      },
    ); 
  }
  static FunctionNode product(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'PRODUCT',
      types: const [List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        return 
      // 1 dimensional multiplication
      inputs.expand((i) => i).reduce((a, b) => a * b);
      }, 
    );
  }
  static FunctionNode multiply(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'MULTIPLY',
      types: const [List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length == 1) {
          return inputs[0];
        }
        // 2 dimensional multiplication
        return 
          inputs.reduce((a, b) {
            final length = a.length > b.length ? a.length : b.length;
            return List.generate(length, (index) {
              final aValue = index < a.length ? a[index] : 1;
              final bValue = index < b.length ? b[index] : 1;
              return aValue * bValue;
            });
          });
      },
    );
  }
  static FunctionNode subtract(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'SUBTRACT',
      types: const [List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        return 
      // 2 dimensional subtraction
      inputs.reduce((a, b) {
        final length = a.length > b.length ? a.length : b.length;
        return List.generate(length, (index) {
          final aValue = index < a.length ? a[index] : 0;
          final bValue = index < b.length ? b[index] : 0;
          return aValue - bValue;
        });
      });
      }, 
    );
  }
  static FunctionNode divide(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'DIVIDE',
      types: const [List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        return 
      // 2 dimensional division
      inputs.reduce((a, b) {
        final length = a.length > b.length ? a.length : b.length;
        return List.generate(length, (index) {
          final aValue = index < a.length ? a[index] : 1;
          final bValue = index < b.length ? b[index] : 1;
          return aValue / bValue;
        });
      });
      },
    );
  }
  static FunctionNode average(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'AVERAGE',
      types: const [List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        return 
      inputs.expand((i) => i).reduce((a, b) => a + b) / inputs.length;
      }, 
    );
  }
  static FunctionNode averageByRow(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'AVERAGE ROWS',
      types: const [List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        return 
      inputs.map((i) => i.reduce((a, b) => a + b) / i.length).toList();
      }, 
    );
  }
  static FunctionNode concatenateString(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'CONCAT STRING',
      types: const [List<String>, List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
      // 2 dimensional concatenation
        return inputs.reduce((a, b) {
          final length = a.length > b.length ? a.length : b.length;
          return List.generate(length, (index) {
            final aValue = index < a.length ? a[index] : "";
            final bValue = index < b.length ? b[index] : "";
            return aValue.toString() + bValue.toString();
          });
        });
      
      }, 
    );
  }
  static FunctionNode concatenateList(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'CONCAT LIST',
      types: const [List<String>, List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        // 2 dimensional concatenation
        return inputs.expand((i) => i).toList();
      }, 
    );
  }
  static FunctionNode concatenateInt(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'CONCAT INT',
      types: const [List<int>],
      function: (List<List<dynamic>> inputs) {
        // 2 dimensional concatenation
        return inputs.reduce((a, b) {
          final length = a.length > b.length ? a.length : b.length;
          return List.generate(length, (index) {
        final aValue = index < a.length ? a[index] : "";
        final bValue = index < b.length ? b[index] : "";
        return int.parse(aValue.toString() + bValue.toString());
          });
        });
      },
    );
  }
  static FunctionNode sin(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'SIN',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.sin(value)).toList();
      },
    );
  }

  static FunctionNode cos(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'COS',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.cos(value)).toList();
      },
    );
  }

  static FunctionNode tan(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'TAN',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.tan(value)).toList();
      },
    );
  }

  static FunctionNode asin(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'ASIN',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.asin(value)).toList();
      },
    );
  }

  static FunctionNode acos(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'ACOS',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.acos(value)).toList();
      },
    );
  }

  static FunctionNode atan(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'ATAN',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.atan(value)).toList();
      },
    );
  }

  
  static FunctionNode power(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'POWER',
      types: const [List<double>, List<double>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('Power function requires exactly 2 inputs');
        }
        final base = inputs[0].expand((i) => i).toList();
        final exponent = inputs[1].expand((i) => i).toList();
        if (base.length != exponent.length) {
          throw ArgumentError('Base and exponent lists must have the same length');
        }
        return List.generate(base.length, (index) {
          return math.pow(base[index], exponent[index]);
        });
      },
    );
  }

  static FunctionNode sqrt(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'SQRT',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.sqrt(value)).toList();
      },
    );
  }

  static FunctionNode log(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'LOG',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.log(value)).toList();
      },
    );
  }

  static FunctionNode log10(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'LOG10',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.log(value) / math.log(10)).toList();
      },
    );
  }

  static FunctionNode exp(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'EXP',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => math.exp(value)).toList();
      },
    );
  }

  static FunctionNode abs(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'ABS',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => value.abs()).toList();
      },
    );
  }

  static FunctionNode ceil(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'CEIL',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => value.ceil()).toList();
      },
    );
  }

  static FunctionNode floor(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'FLOOR',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => value.floor()).toList();
      },
    );
  }

  static FunctionNode round(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'ROUND',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => value.round()).toList();
      },
    );
  }

  static FunctionNode max(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'MAX',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).reduce((a, b) => a > b ? a : b);
      },
    );
  }
  
  static FunctionNode min(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'MIN',
      types: const [List<double>, List<int>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).reduce((a, b) => a < b ? a : b);
      },
    );
  }

  static FunctionNode random(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: inputCount,
      outputCount: 1,
      label: 'RANDOM',
      types: const [List<int>, List<double>, List<String>],
      function: (List<List<dynamic>> inputs) {
        return 
      inputs.expand((i) => i).toList()..shuffle()..first;
      },
    );
  }
  
  static FunctionNode ifNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 3,
      outputCount: 1,
      label: 'IF',
      types: const [List<bool>, List<int>, List<double>, List<String>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 3) {
          throw ArgumentError('IF function requires exactly 3 inputs');
        }
        final condition = inputs[0].expand((i) => i).toList();
        final trueValue = inputs[1].expand((i) => i).toList();
        final falseValue = inputs[2].expand((i) => i).toList();
        if (condition.length != trueValue.length || condition.length != falseValue.length) {
          throw ArgumentError('All input lists must have the same length');
        }
        return List.generate(condition.length, (index) {
          return condition[index] ? trueValue[index] : falseValue[index];
        });
      }
    );
  }
  
  static FunctionNode andNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'AND',
      types: const [List<bool>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('AND function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] && b[index];
        });
      }
    );
  }

  static FunctionNode orNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'OR',
      types: const [List<bool>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('OR function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] || b[index];
        });
      }
    );
  }

  static FunctionNode notNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 1,
      outputCount: 1,
      label: 'NOT',
      types: const [List<bool>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 1) {
          throw ArgumentError('NOT function requires exactly 1 input');
        }
        final a = inputs[0].expand((i) => i).toList();
        return List.generate(a.length, (index) {
          return !a[index];
        });
      }
    );
  }

  static FunctionNode xorNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'XOR',
      types: const [List<bool>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('XOR function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] != b[index];
        });
      }
    );
  }

  static FunctionNode nandNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'NAND',
      types: const [List<bool>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('NAND function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return !(a[index] && b[index]);
        });
      }
    );
  }

  static FunctionNode norNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'NOR',
      types: const [List<bool>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('NOR function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return !(a[index] || b[index]);
        });
      }
    );
  }

  static FunctionNode xnorNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'XNOR',
      types: const [List<bool>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('XNOR function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] == b[index];
        });
      }
    );
  }

  static FunctionNode equalNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'EQUAL',
      types: const [List<int>, List<double>, List<String>, List<bool>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('EQUAL function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] == b[index];
        });
      }
    );
  }

  static FunctionNode notEqualNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'NOT EQUAL',
      types: const [List<int>, List<double>, List<String>, List<bool>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('NOT EQUAL function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] != b[index];
        });
      }
    );
  }

  static FunctionNode greaterThanNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'GREATER THAN',
      types: const [List<int>, List<double>, List<String>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('GREATER THAN function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] > b[index];
        });
      }
    );
  }

  static FunctionNode lessThanNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'LESS THAN',
      types: const [List<int>, List<double>, List<String>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('LESS THAN function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] < b[index];
        });
      }
    );
  }

  static FunctionNode greaterThanOrEqualNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'GREATER THAN OR EQUAL',
      types: const [List<int>, List<double>, List<String>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('GREATER THAN OR EQUAL function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] >= b[index];
        });
      }
    );
  }

  static FunctionNode lessThanOrEqualNode(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 2,
      outputCount: 1,
      label: 'LESS THAN OR EQUAL',
      types: const [List<int>, List<double>, List<String>],
      function: (List<List<dynamic>> inputs) {
        if (inputs.length != 2) {
          throw ArgumentError('LESS THAN OR EQUAL function requires exactly 2 inputs');
        }
        final a = inputs[0].expand((i) => i).toList();
        final b = inputs[1].expand((i) => i).toList();
        if (a.length != b.length) {
          throw ArgumentError('Both input lists must have the same length');
        }
        return List.generate(a.length, (index) {
          return a[index] <= b[index];
        });
      }
    );
  } 

  static FunctionNode percent(Offset position, inputCount) {
    return FunctionNode(
      position: Signal(position),
      inputCount: 1,
      outputCount: 1,
      label: 'PERCENT',
      types: const [List<int>, List<double>],
      function: (List<List<dynamic>> inputs) {
        return inputs.expand((i) => i).map((value) => value / 100).toList();
      },
    );
  }
}