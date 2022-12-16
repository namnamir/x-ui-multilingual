package job

import (
	"x-ui/logger"
	"x-ui/web/service"
)

type CheckInboundJob struct {
	xrayService    service.XrayService
	inboundService service.InboundService
}

func NewCheckInboundJob() *CheckInboundJob {
	return new(CheckInboundJob)
}

func (j *CheckInboundJob) Run() {
	count, err := j.inboundService.DisableInvalidInbounds()
	if err != nil {
		logger.Warning(tr_error_invalid_inbound_logger, err)
	} else if count > 0 {
		logger.Debugf(tr_disabled_inbound, count)
		j.xrayService.SetToNeedRestart()
	}
}
