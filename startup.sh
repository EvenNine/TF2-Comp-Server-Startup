echo "Gameserver is starting please wait"

rm /home/container/tf/cfg/startup.cfg
echo "sv_downloadurl "${FAST_DL}"
sm_demostf_apikey "${DEMO_API_KEY}"
logstf_apikey "${LOGS_API_KEY}"
rcon_password "${RCON_PASSWORD}"
sv_password "${SERVER_PASSWORD}"
tv_port "${STV_PORT}"
tv_password "${STV_PASSWORD}"
tv_enable "${STV_ON_STARTUP}"
tv_name "${STV_NAME}"
exec "${SERVER_CONFIG}"" > /home/container/tf/cfg/startup.cfg

clear

echo "startup commands follow:"
echo
echo "sv_downloadurl "${FAST_DL}"
sm_demostf_apikey "Hidden"
logstf_apikey "Hidden"
rcon_password "${RCON_PASSWORD}"
sv_password "${SERVER_PASSWORD}"
tv_port "${STV_PORT}"
tv_password "${STV_PASSWORD}"
tv_enable "${STV_ON_STARTUP}"
tv_name "${STV_NAME}"
exec "${SERVER_CONFIG}""


echo ""
echo "Deleting demos older then ${DELETE_DEMOS_AFTER} days"

find /home/container/tf/ -name "*.dem" -type f -mtime +${DELETE_DEMOS_AFTER} -delete
echo "demos cleared"
find /home/container/tf/logs/ -name "*.log" -type f -mtime +${DELETE_LOGS_AFTER} -delete
echo "Server logs cleared"
find /home/container/tf/addons/sourcemod/logs/ -name "*.log" -type f -mtime +${DELETE_LOGS_AFTER} -delete
echo "Sourcemod logs cleared"

sleep 5

clear

./srcds_run -game tf -console -port ${SERVER_PORT} +map ${SRCDS_MAP} +ip 0.0.0.0 -strictportbind -norestart +sv_setsteamaccount "${STEAM_ACC}" +exec "startup"
