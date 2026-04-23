"use server";

import { prisma } from "@/lib/prisma";

// BUG: getSession() yo'q — xavfsizlik xatosi!
export async function deleteProject(projectId: string) {
  await prisma.project.delete({
    where: { id: projectId },
  });

  return { success: true };
}
