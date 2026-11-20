variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  description = "Prefix for all resource names"
  type        = string
  default     = "multi"
}

# ---------- Service 1: web ----------
variable "web_image" {
  type    = string
  default = "nginx:latest"
}

variable "web_port" {
  type    = number
  default = 80
}

variable "web_desired_count" {
  type    = number
  default = 2
}

# ---------- Service 2: api ----------
variable "api_image" {
  type    = string
  default = "httpd:latest"
}

variable "api_port" {
  type    = number
  default = 80
}

variable "api_desired_count" {
  type    = number
  default = 2
}

# ---------- Task size (both services) ----------
variable "cpu" {
  type    = number
  default = 256
}

variable "memory" {
  type    = number
  default = 512
}
