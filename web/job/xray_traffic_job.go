package job

import (
	"x-ui/logger"
	"x-ui/web/service"
)

type XrayTrafficJob struct {
	xrayService    service.XrayService
	inboundService service.InboundService
}

func NewXrayTrafficJob() *XrayTrafficJob {
	return new(XrayTrafficJob)
}

func (j *XrayTrafficJob) Run() {
	if !j.xrayService.IsXrayRunning() {
		return
	}
	traffics, err := j.xrayService.GetXrayTraffic()
	if err != nil {
		logger.Warning(tr_error_get_traffic_logger, err)
		return
	}
	err = j.inboundService.AddTraffic(traffics)
	if err != nil {
		logger.Warning(tr_error_add_traffic_logger, err)
	}
}
