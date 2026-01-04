./gradlew :system-tests:bom-tests:test --tests "BomSmokeTests\$ControlPlaneDcp.assertRuntimeReady" -DincludeTags="EndToEndTest" --rerun-tasks --info --debug-jvm
logdy --port 7070
export JAVA_TOOL_OPTIONS=""
export JAVA_TOOL_OPTIONS="-Dhttp.proxyHost=tudas-proxy.rd.hu.t-internal.com -Dhttp.proxyPort=3128 -Dhttps.proxyHost=tudas-proxy.rd.hu.t-internal.com -Dhttps.proxyPort=3128 -Dhttp.nonProxyHosts="
export 
export JAVA_TOOL_OPTIONS="-Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8888 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=8888 -Dhttp.nonProxyHosts="

unset NO_PROXY;export HTTP_PROXY=127.0.0.1:8888;export HTTPS_PROXY=127.0.0.1:8888
unset NO_PROXY;export HTTP_PROXY=tudas-proxy.rd.hu.t-internal.com:3128;export HTTPS_PROXY=tudas-proxy.rd.hu.t-internal.com:3128