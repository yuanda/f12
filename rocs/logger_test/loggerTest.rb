require 'test/unit'
require '../logger/logger.rb'
require '../configio.rb'

class LoggerTest < Test::Unit::TestCase
	
	
	def test_log_error
		loggerError = Logger.instance
		errorText = "Error test: #{Random.rand(100000)}"
		loggerError.error errorText
		logFile = File.read("server.log")
		assert(logFile.include?(errorText))
	end
	
	def test_log_info
		loggerInfo = Logger.instance
		loggedText = "Info test: #{Random.rand(100000)}"
		loggerInfo.info loggedText
		logFile = File.read("server.log")
		assert(logFile.include?(loggedText))
	end
	
	def test_log_warn
		loggerWarn = Logger.instance
		warnText = "Warn test: #{Random.rand(100000)}"
		loggerWarn.warn warnText
		logFile = File.read("server.log")
		assert(logFile.include?(warnText))
	end
	
	def test_setConfig
		configIO = ConfigIO.instance
		configIO.read("../config.yml")
		logger = Logger.instance
		logger.setConfig(configIO)
		ioText = "configIO test: #{Random.rand(100000)}"
		logger.info ioText
		configFile = File.read("server.log")
		assert(configFile.include?(ioText), "Config not set.")
	end	
	
	def test_stderr
		loggerStdErr = Logger.instance 
		stdErrText = "Stderr Test: #{Random.rand(100000)}"
		$stderr = File.open("stderr.txt", "w")
		loggerStdErr.log("info", stdErrText)
		$stderr.close
		stderrFile = File.read("stderr.txt")
		puts "This is the file: #{stderrFile}"
		assert(stderrFile.include?(stdErrText), "Stderr not written to.")
		
	end
	
end
