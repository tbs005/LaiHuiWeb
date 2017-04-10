package com.cyparty.laihui.utilities;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by zhu on 2017/2/17.
 */
public class SessionListener implements HttpSessionListener {
    @Override
    public void sessionCreated(HttpSessionEvent event) {
        HttpSession ses = event.getSession();
        String id=ses.getId()+ses.getCreationTime();
        SummerConstant.UserMap.put(id, Boolean.TRUE); //����û�
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        HttpSession ses = event.getSession();
        String id=ses.getId()+ses.getCreationTime();
        synchronized (this) {
            //�û�����һ
            SummerConstant.UserMap.remove(id); //���û������Ƴ������û���Ϊһ��map
        }
    }
}
