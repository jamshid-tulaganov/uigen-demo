"use server";

import { getSession } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

export async function deleteProject(projectId: string) {
  const session = await getSession();

  if (!session) {
    return { success: false, error: "Unauthorized" };
  }

  const project = await prisma.project.findUnique({
    where: { id: projectId },
  });

  if (!project || project.userId !== session.userId) {
    return { success: false, error: "Project not found" };
  }

  await prisma.project.delete({
    where: { id: projectId },
  });

  return { success: true };
}
