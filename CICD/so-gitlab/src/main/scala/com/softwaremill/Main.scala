package com.softwaremill

import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import com.typesafe.scalalogging.StrictLogging

import java.util.concurrent.Executors
import scala.concurrent.{Await, ExecutionContext}
import scala.concurrent.duration.DurationInt
import scala.util.{Failure, Properties, Success, Try}

object Main extends App with StrictLogging {

  implicit val ec: ExecutionContext = ExecutionContext.fromExecutor(Executors.newCachedThreadPool())
  implicit val system: ActorSystem  = ActorSystem()

  var isOk = true

  val routes = get {
    path("status") {
      if (isOk) {
        logger.info("Status ok")
        complete("""{"status": "ok"}""")
      } else {
        logger.error("Error")
        complete(500, "ERROR")
      }
    } ~
      path("environment") {
        val environment = Properties.envOrElse("SML_ENV", "")
        logger.info(s"Environment: $environment")
        complete(s"""{"environment": "$environment"}""")
      }
  } ~ post {
    path("dowork") {
      parameter("magicnumber".as[Int]) { mn =>
        if (mn == 42) {
          sys.exit(1)
        } else {
          if (mn % 2 == 0) {
            isOk = true
            complete("done")
          } else {
            isOk = false
            complete("try again")
          }
        }
      }
    }
  }

  Http().newServerAt("0.0.0.0", 8081).bind(routes).onComplete {
    case Success(binding) =>
      logger.info(s"Server started ${binding.localAddress}")
      sys.addShutdownHook {
        Try(Await.ready(binding.unbind(), 1.seconds)) match {
          case Failure(ex) =>
            logger.warn("Could not unbind AkkaHttp binding in a given time!", ex)
          case Success(_) =>
            logger.debug("AkkaHttp has been unbounded")
        }
        Try(Await.ready(system.terminate(), 1.seconds)) match {
          case Failure(ex) =>
            logger.warn("Could not terminate Actor System in a given time!", ex)
          case Success(_) =>
            logger.debug("Actor System has been terminated")
        }
      }
    case Failure(f) =>
      logger.error("Cannot start server", f)
  }
}
