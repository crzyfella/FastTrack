using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Business.Utilities.Trendlines
{
    public class NumberItem : ValueItem<double>
    {
        private double _x;

        /// <summary>
        /// X actual value of the data item
        /// </summary>
        public override double X
        {
            get
            {
                return this._x;
            }

            set
            {
                if (this._x != value)
                {
                    this._x = value;
                    this.NotifyPropertyChanged("X");
                }
            }
        }

        /// <summary>
        /// The value for X for calculations
        /// </summary>
        public override double ConvertedX
        {
            get
            {
                return this.X;
            }
            set
            {
                if (this.X != value)
                {
                    this.X = value;
                }
            }
        }

        /// <summary>
        /// Creates a new trend item
        /// </summary>
        /// <returns>The trend item</returns>
        public override object NewTrendItem()
        {
            return new NumberItem();
        }

        /// <summary>
        /// Creates a copy of the value item
        /// </summary>
        /// <returns>The copy</returns>
        public override object CreateCopy()
        {
            return new NumberItem()
            {
                X = this.X,
                Y = this.Y
            };
        }
    }
}
