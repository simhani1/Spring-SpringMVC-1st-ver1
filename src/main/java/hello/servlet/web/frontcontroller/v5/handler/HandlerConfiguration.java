package hello.servlet.web.frontcontroller.v5.handler;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HandlerConfiguration {

    @Bean
    public HandlerMappingMap getHandlerMappingMapImpl() {
        return new HandlerMappingMapImpl();
    }

    @Bean
    public HandlerAdapters getHandlerAdaptersImpl() {
        return new HandlerAdaptersImpl();
    }

}
