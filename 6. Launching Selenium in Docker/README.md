# 6. Launching Selenium in Docker


####Launching Selenium in Docker.


When managing every setup about Selenium in local, many problems occur.

However, launching Selenium in Docker make it much easier.

For those who are not familiar with Docker, a brief description of Docker is that Docker is like a little box in linux. This box is a like small environment which you can do whatever you want. Due to the environment is very simple, few problems occur. When other people want to run your program, you can just give this little box to them. Because of running the program in the same environment(little box), wierd problems will be avoided.

The link below teach us how to setup Docker and selenium:
[Link](http://rpubs.com/johndharrison/RSelenium-Docker)

After building docker machine and pulling standalone-firefox, we can run 'RSelenium' easily.


By the way, because using selenium by Docker, there will be no browser poping out.
There's a way to check our browser's is that We can use the code below to check the browser's screenshot.

```
remDr$screenshot(display = TRUE)
```



[Code Example](https://github.com/r3dmaohong/R_Notes/blob/master/6.%20Launching%20Selenium%20in%20Docker/seleniumTest.R)