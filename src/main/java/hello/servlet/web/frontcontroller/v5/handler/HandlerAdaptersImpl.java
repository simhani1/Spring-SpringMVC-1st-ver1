package hello.servlet.web.frontcontroller.v5.handler;

import hello.servlet.web.frontcontroller.v5.MyHandlerAdapter;
import hello.servlet.web.frontcontroller.v5.adapter.ControllerV3HandlerAdapter;
import hello.servlet.web.frontcontroller.v5.adapter.ControllerV4HandlerAdapter;

import java.util.ArrayList;
import java.util.List;

public class HandlerAdaptersImpl implements HandlerAdapters {

    private final List<MyHandlerAdapter> handlerAdapters;

    public HandlerAdaptersImpl() {
        handlerAdapters = new ArrayList<>();
    }

    @Override
    public List<MyHandlerAdapter> getHandlerAdapters() {
        init();
        return handlerAdapters;
    }

    private void init() {
        handlerAdapters.add(new ControllerV3HandlerAdapter());
        handlerAdapters.add(new ControllerV4HandlerAdapter());
    }

}
