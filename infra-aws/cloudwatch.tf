# CloudWatch Dashboard and Alarms
resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = "MyDashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x = 0
        y = 0
        width = 24
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", "${aws_instance.web.id}"],
            ["AWS/EC2", "CPUUtilization", "InstanceId", "${aws_instance.web2.id}"]
          ]
          period = 300
          stat = "Average"
          region = "us-east-1"
          title = "EC2 Instance CPU Utilization"
        }
      }
    ]
  })
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high_cpu_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors high CPU utilization"
  dimensions = {
    InstanceId = aws_instance.web.id
  }
  actions_enabled = true
  alarm_actions   = []
  ok_actions      = []
  insufficient_data_actions = []
}