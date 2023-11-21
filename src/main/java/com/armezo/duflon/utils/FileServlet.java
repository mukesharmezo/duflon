package com.armezo.duflon.utils;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@WebServlet("/images/*")
@Component
public class FileServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	@Value("${file.path}")
    private String filePath;

		@Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws IOException
	    {
	        String filename = URLDecoder.decode(request.getPathInfo().substring(1), "UTF-8");
	        //File file = new File(filePath, filename);
	        File file = new File("/home/ubuntu/armezo/", filename);
	        response.setHeader("Content-Type", getServletContext().getMimeType(filename));
	        response.setHeader("Content-Length", String.valueOf(file.length()));
	        response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");
	        Files.copy(file.toPath(), response.getOutputStream());
	    }
	}

