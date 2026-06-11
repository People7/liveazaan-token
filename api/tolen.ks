const { RtcTokenBuilder, RtcRole } = require('agora-access-token');

const APP_ID = 'a3a80917a1fa413cb2ebdc88733ac507';
const APP_CERTIFICATE = 'a8975bc797ea437cbf24fd404fe17c60';

module.exports = (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET');
  
  const channelName = req.query.channel;
  
  if(!channelName) {
    return res.status(400).json({ error: 'Channel name required' });
  }

  const uid = 0;
  const role = RtcRole.PUBLISHER;
  const expireTime = 3600; // 1 hour
  const currentTime = Math.floor(Date.now() / 1000);
  const privilegeExpireTime = currentTime + expireTime;

  const token = RtcTokenBuilder.buildTokenWithUid(
    APP_ID,
    APP_CERTIFICATE,
    channelName,
    uid,
    role,
    privilegeExpireTime
  );

  return res.status(200).json({ token: token });
};
