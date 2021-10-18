using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SysAtividade.Domain.Entities;

namespace SysAtividade.Domain.Interfaces.Repositories
{
    public interface IAtividadeRepo : IGeralRepo
    {
        Task<Atividade[]> PegaTodasAsync();
        Task<Atividade> PegaPorIdAsync(int id);
        Task<Atividade> PegaPorTituloAsync(string titulo);
    }
}