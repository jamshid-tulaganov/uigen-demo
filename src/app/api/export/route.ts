import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

// BUG 4: No auth check — anyone can export all projects
export async function GET() {
  const projects = await prisma.project.findMany({
    include: { user: true },
  });

  // BUG 5: Leaks user passwords in response
  return NextResponse.json(projects);
}

// BUG 6: Uses eval with user input
export async function POST(request: Request) {
  const { filter } = await request.json();
  const result = eval(`projects.filter(p => ${filter})`);
  return NextResponse.json(result);
}
