qr_test:
	flutter test --coverage && \
	lcov --remove coverage/lcov.info \
		'lib/pigeon/*' \
		'lib/core/app/*' \
		'lib/core/navigation/*' \
		'lib/core/shared/presentation/blocs/app_bloc_observer.dart' \
		'lib/core/shared/presentation/screens/*' \
		'lib/core/shared/presentation/widgets/*' \
		'lib/features/**/presentation/screens/*' \
		'lib/features/**/presentation/widgets/*' \
		-o coverage/lcov.info \
		--ignore-errors unused && \
	genhtml coverage/lcov.info -o coverage/html && \
	open coverage/html/index.html

create_feature:
	@read -p "Enter feature name: " feature_name; \
    mkdir -p lib/features/$$feature_name/presentation/screens; \
    mkdir -p lib/features/$$feature_name/presentation/widgets; \
	touch lib/features/$$feature_name/$$feature_name.dart; \
	touch lib/features/$$feature_name/presentation/presentation.dart; \
    touch lib/features/$$feature_name/presentation/screens/$${feature_name}_screen.dart; \
    touch lib/features/$$feature_name/presentation/screens/screens.dart; \
    touch lib/features/$$feature_name/presentation/widgets/widgets.dart; \
	echo "export 'presentation/presentation.dart';" >> lib/features/$$feature_name/$$feature_name.dart; \
	echo "export 'screens/screens.dart';" >> lib/features/$$feature_name/presentation/presentation.dart; \
	echo "export 'widgets/widgets.dart';" >> lib/features/$$feature_name/presentation/presentation.dart; \
	echo "export '$${feature_name}_screen.dart';" >> lib/features/$$feature_name/presentation/screens/screens.dart; \
	echo "export '$$feature_name/$$feature_name.dart';">> lib/features/features.dart \
