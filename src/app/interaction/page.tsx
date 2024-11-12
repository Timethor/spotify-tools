"use client"
import { Button } from "@carbon/react"

export default function Interaction() {
  return (
    <Button onClick={() => { console.log('hi')}}>Test button</Button>
  )
}
