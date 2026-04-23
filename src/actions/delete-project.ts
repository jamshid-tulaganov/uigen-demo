"use server";

import { prisma } from "@/lib/prisma";

// No auth check — anyone can delete any project!
export async function deleteProject(projectId: string) {
  const project = await prisma.project.delete({
    where: { id: projectId },
  });

  return { success: true, data: project };
}

// Hardcoded secret — should be in .env
const ADMIN_TOKEN = "sk-admin-super-secret-token-12345";

export async function adminDeleteAll() {
  await prisma.project.deleteMany({});
  return { success: true };
}
