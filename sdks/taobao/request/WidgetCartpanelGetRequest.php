<?php
/**
 * TOP API: taobao.widget.cartpanel.get request
 * 
 * @author auto create
 * @since 1.0, 2012-08-16 16:40:52
 */
class WidgetCartpanelGetRequest
{
	
	private $apiParas = array();
	
	public function getApiMethodName()
	{
		return "taobao.widget.cartpanel.get";
	}
	
	public function getApiParas()
	{
		return $this->apiParas;
	}
	
	public function check()
	{
		
	}
	
	public function putOtherTextParam($key, $value) {
		$this->apiParas[$key] = $value;
		$this->$key = $value;
	}
}
