package com.wushengde.springmvc.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class SecondInterceptor implements HandlerInterceptor {

	/**
	 * 渲染视图之后调用该方法
	 * 作用：释放资源
	 */
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		System.out.println("SecondInterceptor:afterCompletion");
	}

	/**
	 * 调用目标方法之后，渲染视图之前，调用该方法：
	 * 作用：可以对请求域中的属性或视图做出修改。
	 */
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		System.out.println("SecondInterceptor:postHandle");
	}

	
	/**
	 * 该方法在目标方法之前被调用。若返回true，则继续调用后续的拦截器和目标方法
	 * 若返回值为false，则不会调用后续的拦截器和方法
	 * 作用：方便配置 权限，日志，事务等等
	 */
	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
		
		System.out.println("SecondInterceptor:preHandle");
		return true;
	}

}
