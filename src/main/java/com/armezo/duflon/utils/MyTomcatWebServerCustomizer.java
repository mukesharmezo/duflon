package com.armezo.duflon.utils;

import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class MyTomcatWebServerCustomizer implements WebMvcConfigurer {

    String myExternalFilePath = "file:C:/ParticipantUploadedFiles/"; // end your path with a /

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/ParticipantUploadedFiles/**").addResourceLocations(myExternalFilePath);
    }

}
