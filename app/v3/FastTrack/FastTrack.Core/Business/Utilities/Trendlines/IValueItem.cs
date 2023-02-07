using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Business.Utilities.Trendlines
{
    /// <summary>
    /// Interace which each value item type must implement in order to be usable in calculation
    /// </summary>
    public interface IValueItem
    {
        /// <summary>
        /// Raised when the data in the item is changed
        /// </summary>
        event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        /// <summary>
        /// Returns the value for X for calculations
        /// </summary>
        double ConvertedX { get; set; }

        /// <summary>
        /// Y value of the data item
        /// </summary>
        double Y { get; set; }


        /// <summary>
        /// Creates a copy of the value item
        /// </summary>
        /// <returns>The copy</returns>
        object CreateCopy();

        /// <summary>
        /// Creates a new trend item
        /// </summary>
        /// <returns>The trend item</returns>
        object NewTrendItem();

    }
}
