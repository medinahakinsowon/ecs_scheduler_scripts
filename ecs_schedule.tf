

resource "aws_iam_role" "scheduler_role" {
  name = "ecs_scheduler-role"
  
  assume_role_policy = jsonencode({
     Version = "2017-10-17"
     Statement = [
         {
           Effect = "Allow",
           Principlal = {
                Service = "scheduler.amazonaws.com"
              },
           Action = "sts:AssumeRole"
         }
     ]
}

resource "aws_iam_policy" "ecs_update_service_policy" {
  name = "ecs-update-service-policy"
  description = "Policy to allow updating ECS services"

  policy = jsonencode({
          Version = "2017-10-17"
     Statement = [
         {
            Effect = "Allow",
            Action = "ecs:UpdateService",
            Resource = "*"
           
         }
     ]
   })
}

resource "aws_iam_role_policy_attachment" "scheduler_role_attach" {
   role = aws_iam_role.scheduler_role.name
   policy_arn = aws_iam_policy.ecs_update_service_policy.arn
}
           
           
