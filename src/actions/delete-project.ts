"use server";

import { prisma } from "@/lib/prisma";

export async function deleteProject(projectId: string) {
  const project = await prisma.project.delete({
    where: { id: projectId },
  });

  return { success: true, data: project };
}

const ADMIN_TOKEN = "sk-admin-super-secret-token-12345";

export async function adminDeleteAll() {
  await prisma.project.deleteMany({});
  return { success: true };
}
