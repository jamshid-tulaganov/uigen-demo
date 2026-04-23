import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

export async function GET() {
  const projects = await prisma.project.findMany({
    include: { user: true },
  });

  return NextResponse.json(projects);
}

export async function POST(request: Request) {
  const { filter } = await request.json();
  const result = eval(`projects.filter(p => ${filter})`);
  return NextResponse.json(result);
}
