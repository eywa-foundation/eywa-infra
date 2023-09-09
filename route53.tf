resource "cloudflare_record" "relayer1" {
  zone_id = var.cloudflare_zone.id
  name    = "relayer.neytiri.eywa"
  value   = aws_eip.eywa_relayer_static_ip[0].public_ip
  proxied = false
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "relayer2" {
  zone_id = var.cloudflare_zone.id
  name    = "relayer.toruk.eywa"
  value   = aws_eip.eywa_relayer_static_ip[1].public_ip
  proxied = false
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "relayer3" {
  zone_id = var.cloudflare_zone.id
  name    = "relayer.eytukan.eywa"
  value   = aws_eip.eywa_relayer_static_ip[2].public_ip
  proxied = false
  type    = "A"
  ttl     = 1
}
