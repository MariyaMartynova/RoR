ActiveMerchant::Billing::Base.mode= :test
  paypal_options={
    :login=>'4.m_1312360477_biz_api1.live.cn',
    :password=>'1312360516',
    :signature=>'AB4qbqgidS48DqaGnjCQh7ZkQj.mADKRj-jOieg..zZeynRm8-bWbsF5'
   }
  GATEWAY=ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
  EXPRESS_GATEWAY=ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
