#!/bin/bash
FEATURE=$1
FEATURE_PASCAL=$(python3 -c "print(''.join(w.capitalize() for w in '${FEATURE}'.split('_')))")
BASE="lib/src/features/$FEATURE"
PACKAGE="invastro"

mkdir -p $BASE/data/models
mkdir -p $BASE/data/services
mkdir -p $BASE/presentation/controllers
mkdir -p $BASE/presentation/providers
mkdir -p $BASE/presentation/screens
mkdir -p $BASE/presentation/widgets



# ─── Service ─────────────────────────────────────────────
cat > $BASE/data/services/${FEATURE}_service.dart << EOF
import 'package:${PACKAGE}/src/core/network/api_service.dart';

class ${FEATURE_PASCAL}Service {

}
EOF

# ─── Controller ──────────────────────────────────────────
cat > $BASE/presentation/controllers/${FEATURE}_controller.dart << EOF
import '../../data/services/${FEATURE}_service.dart';

class ${FEATURE_PASCAL}Controller {
 
}
EOF

# ─── Provider ────────────────────────────────────────────
cat > $BASE/presentation/providers/${FEATURE}.dart << EOF
import 'package:flutter/material.dart';

class ${FEATURE_PASCAL} with ChangeNotifier {
 
}
EOF

# ─── Screen ──────────────────────────────────────────────
cat > $BASE/presentation/screens/${FEATURE}_screen.dart << EOF
import 'package:flutter/material.dart';

class ${FEATURE_PASCAL}Screen extends StatelessWidget {
  static const routeName = '/${FEATURE}_screen';
  const ${FEATURE_PASCAL}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: const []));
  }
}
EOF

echo "✅ Feature '${FEATURE_PASCAL}' created!"
echo "🔴 Don't forget to:"
echo "   1. Update PACKAGE name at the top of this script"
echo "   2. Register ${FEATURE_PASCAL} and ${FEATURE_PASCAL}Navigations in app_bloc_providers.dart"