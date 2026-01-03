./gradlew :system-tests:bom-tests:test --tests "BomSmokeTests\$ControlPlaneDcp.assertRuntimeReady" -DincludeTags="EndToEndTest" --info --debug-jvm
logdy --port 7070